Message-ID: <40E404B2.8040101@gmx.de>
Date: Thu, 01 Jul 2004 14:33:54 +0200
From: =?ISO-8859-15?Q?Christian_Tr=F6ster?= <please.see.sig@gmx.de>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Notifying a user space application
References: <200407010029.05546.please.see.sig@gmx.de> <1088662847.6010.2.camel@lucy.pep-kaufbeuren.de>
In-Reply-To: <1088662847.6010.2.camel@lucy.pep-kaufbeuren.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Stefan!

Stefan Nickl schrieb:
 > On Thu, 2004-07-01 at 00:29, Christian Tröster wrote:
 >>I'd like to notify a user space application if an interrupt occurs. I
 >>had no
 >>problems to install a custom signal handler but I am not sure what's
 >>the best
 >>way to notify the application.
 > Mostly a stripped-down ppdev.
Thanks for posting your code. It works perfectly. I only had to change
one line adding an initialization value for the spin lock.

 > /*
 >  * Open the device. It is single-open.
 >  */
 > int wfi_s_count = 0;
 > spinlock_t wfi_s_lock;
spinlock_t wfi_s_lock = SPIN_LOCK_UNLOCKED;

 > static int wfi_open (struct inode *inode, struct file *file)
 > {
 >         file->private_data = &wfi_global;

Bye, Christian

--
| Mail: c dot troester at gmx dot de | PGP-Id: FA006C74 |

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
