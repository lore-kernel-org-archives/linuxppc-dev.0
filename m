Message-ID: <3A8BE0AA.65554FA3@raleigh.ibm.com>
Date: Thu, 15 Feb 2001 08:59:06 -0500
From: Ralph Blach <rcblach@raleigh.ibm.com>
MIME-Version: 1.0
To: Roland Dreier <roland@topspincom.com>
CC: Embedded Linux list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Wait queue question
References: <3A8A9EB2.660A7A2D@raleigh.ibm.com> <52snlh41g5.fsf@love-boat.topspincom.com>
Content-Type: multipart/mixed;
 boundary="------------0DDE7413DE16C9B00EB20DBB"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------0DDE7413DE16C9B00EB20DBB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Roland,

Ok, but were is an example of how to use a wait_event macro.  I dont see
it in any of the documentation.

Chip
Roland Dreier wrote:
>
>     Ralph> If I have a wait queue thats I am using to wake up a device
>     Ralph> driver read from an interrupt service routine.  If I get
>     Ralph> three interrupt and three wake_up_interrables, will I need
>     Ralph> to execute three sleep_ons to get the wait queue back to
>     Ralph> the null state, or is it just back after the first
>     Ralph> sleep_on?
>
> You really don't want to use sleep_on() any more (Linux wants to
> remove it out for 2.5).  Take a look at
>
> <http://lwn.net/2001/0201/a/sleep-fix.php3>
>
> for a safer way to sleep, or use the wait_event macro (in
> linux/sched.h).
>
> Roland
--------------0DDE7413DE16C9B00EB20DBB
Content-Type: text/x-vcard; charset=us-ascii;
 name="rcblach.vcf"
Content-Description: Card for Ralph Blach
Content-Disposition: attachment;
 filename="rcblach.vcf"
Content-Transfer-Encoding: 7bit

begin:vcard
n:Blach;Ralph
tel;work:919-543-1207
x-mozilla-html:TRUE
url:www.ibm.com
org:IBM MicroElectronics
adr:;;3039 Cornwallis		;RTP;NC;27709;USA
version:2.1
email;internet:rcblach@raleigh.ibm.com
x-mozilla-cpt:;15936
fn:Ralph Blach
end:vcard

--------------0DDE7413DE16C9B00EB20DBB--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
