Date: Tue, 15 Apr 2003 13:53:11 -0700
From: Matt Porter <porter@cox.net>
To: Takeharu KATO <tk1219@alles.or.jp>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [TRIVIAL PATCH][2.5.67] Compile fix to include appropriate file in bootloader
Message-ID: <20030415135311.C11915@home.com>
References: <3E9C33AC.6090204@alles.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E9C33AC.6090204@alles.or.jp>; from tk1219@alles.or.jp on Wed, Apr 16, 2003 at 01:30:36AM +0900
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Apr 16, 2003 at 01:30:36AM +0900, Takeharu KATO wrote:
> Dear maintainers:
>
> I use Linux-2.5.67 on PowerPC4xx and apply the patch which is
> attached in this mail to compile it.
> Because Linux-2.5.67 kernel attempt to include header file for mpc8xx.
> Please apply this patch.

Whoops, I've had this fix in my working tree for a while now.
Thanks for the reminder.  Committed.

--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
