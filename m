Message-ID: <004e01c30db8$10b3d3b0$370da8c0@aman>
From: "Aman" <aman@mistralsoftware.com>
To: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Shell prompt - Command not visible
Date: Tue, 29 Apr 2003 00:27:50 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All

To enable/ disable the shell prompt in linuxppc for IBM 440GP, I wrote two
script files. They are as follows

/**********************************************************************/
/* enable_cli.sh: This script is to enable the shell prompt */

grep -v 'sh:123:respawn:/bin/sh < /dev/console > /dev/console 2>
/dev/console' /etc/inittab > inittab.tmp
echo 'sh:123:respawn:/bin/sh < /dev/console > /dev/console 2> /dev/console'
>> inittab.tmp
mv inittab.tmp /etc/inittab
init q
/**********************************************************************/
/*disable_cli.sh: This script is to disable the shell prompt */

grep -v 'sh:123:respawn:/bin/sh < /dev/console > /dev/console 2>
/dev/console' /etc/inittab > inittab.tmp
mv inittab.tmp /etc/inittab
init q
/**********************************************************************/

To enable shell prompt ,  I give the command "sh enable_cli.sh, to disable
the shell prompt "sh disable_cli.sh"

First time things work fine ie enable/disable shell prompt.When enabled, in
the shell prompt I can execute the command from the shell prompt. If I
disable the shell prompt and enable for the second time, I get the prompt
and I can execute command in the prompt, however the commands I type on the
prompt is not visible.
I type the enter key continuously I get the shell prompt like this
sh-2.05a#  sh-2.05a#   sh-2.05a#  sh-2.05a#  sh-2.05a#  sh-2.05a#  sh-2.05a#
sh-2.05a# sh-2.05a# sh-2.05a#  sh-2.05a#   sh-2.05a#  sh-2.05a#  sh-2.05a#
sh-2.05a#  sh-2.05a#  sh-2.05a# sh-2.05a# sh-2.05a#  sh-2.05a#   sh-2.05a#
sh-2.05a#  sh-2.05a#  sh-2.05a#  sh-2.05a#  sh-2.05a# sh-2.05a#

Can anybody help me in solving this issue

Regards
Aman


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
