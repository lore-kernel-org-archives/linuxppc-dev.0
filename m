In-Reply-To: <20000108171526.B8126@suse.de>
Date: Sat, 8 Jan 2000 17:31:28 +0100
To: linuxppc-dev@lists.linuxppc.org
From: BenH <bh40@calva.net>
Subject: Re: write into OF tree like nvsetenv
Message-Id: <20000108173128.026187@192.168.1.10>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jan 8, 2000, Olaf Hering <olh@suse.de> wrote:

>it is possible to write into the OF settings to adjust the boot
>variables? nvsetenv do not work anymore on newer machines.
>
>Is there any way to change variables like "boot-device"?
>The idea is to automate the generation of yaboot.conf and booting via
>the os-chooser script.

nvsetenv needs fixing. There's a tool that comes with poof that should
work until I fix nvsetenv. Also, mvram is not accessible at all yet on
UMA machines (I'm working on that but it will only work when booting from
OF, not with BootX).


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
