$Files = Get-ChildItem -Path '.\Configs\'
#$config = '.\Configs\Router.conf'

foreach ($config in $Files.Fullname) {
    Write-Host "Test File $config" -ForegroundColor Yellow
    Describe 'local user' {
        It "test if local user exist" {
            $config | Should -FileContentMatch "user jsomeone nthash"
        }
    }


    Describe 'AAA' {
        it "aaa group" {
            $config | Should -FileContentMatch "aaa group server radius rad_eap"
            $config | Should -FileContentMatch "server 10.0.1.1 auth-port 1812 acct-port 1813"
        }
        It "aaa authentication" {
            $config | Should -FileContentMatch "aaa authentication login eap_methods group rad_eap"
            $config | Should -FileContentMatch "aaa session-id common"
        }
    }

    Describe 'NTP Server' {
        it "if all NTP server exist" {
            $config | Should -FileContentMatch "ntp server pool.ntp.org"
            $config | Should -FileContentMatch "ntp server asia.pool.ntp.org"
        }
    }
}
