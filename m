Message-ID: <4084FFEE.4070308@dgt-lab.com.pl>
Date: Tue, 20 Apr 2004 12:48:14 +0200
From: Wojciech Kromer <krom@dgt-lab.com.pl>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: console terminal on mpc8xx
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


i have mpx8xx custom board with console on SMC1

but there are some problems using it as a terminal with minicom

here is some otputs:


# stty -a
speed 115200 baud; rows 0; columns 0;
intr = ^C; quit = ^\; erase = ^?; kill = ^U; eof = ^D; eol = <undef>;
eol2 = <undef>; start = ^Q; stop = ^S; susp = ^Z; rprnt = ^R; werase = ^W;
lnext = ^V; flush = ^O; min = 1; time = 0;
-parenb -parodd cs8 hupcl -cstopb cread clocal -crtscts
-ignbrk brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr icrnl ixon
-ixoff
-iuclc -ixany imaxbel
opost -olcuc -ocrnl onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0
vt0 ff0
isig icanon iexten echo echoe echok -echonl -noflsh -xcase -tostop -echoprt
echoctl echoke
#

and programs using stdandard \e[x;yH command to set cursor position
displays correct only first two lines

TERM is set to vt102 booth on minicom and console

and:
-setting  'stty rows 24 columns 80 this'  changes nothing
-same program on telnet session works fine


Q:
 -where the problem is (kernel, minicom, program, tty setings, or whatever)?
- how to correct this problem?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
