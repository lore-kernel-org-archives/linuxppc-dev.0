Date: Sat, 8 Jan 2000 17:15:26 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: write into OF tree like nvsetenv
Message-ID: <20000108171526.B8126@suse.de>
Reply-To: linuxppc-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

it is possible to write into the OF settings to adjust the boot
variables? nvsetenv do not work anymore on newer machines.

Is there any way to change variables like "boot-device"?
The idea is to automate the generation of yaboot.conf and booting via
the os-chooser script.


Gruss Olaf

-- 
 $ man 1 current_release

BUGS
       Users never read manuals...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
