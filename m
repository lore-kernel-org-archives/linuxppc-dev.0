Message-ID: <20020802170326.52862.qmail@web20702.mail.yahoo.com>
Date: Fri, 2 Aug 2002 10:03:26 -0700 (PDT)
From: bhupinder sahran <bhup_sah@yahoo.com>
Subject: Re: cannot execute zimage
To: vandana mehtani <vandana_mehtani123@rediffmail.com>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20020802055646.8330.qmail@webmail17.rediffmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi
It's very tough to find out from the information u
have provided.
After downloading the kernel.
First u have to set ur cross compiler path in Makfile.
Thne u have to give make xconfig to configure the
kernel.
Then configure the kernel acc. to ur requirement.
Then give make clean, make dep ,make zImage...
U may have some luck.

Thanx
Bhupi




--- vandana  mehtani
<vandana_mehtani123@rediffmail.com> wrote:
>
> hi all,
> i ahve downoaded the ppc kernel source version 2.4.2
> from
> ppckernel.org..
> when i do a make bzimage...
> there goes this problem.
> cannot execute shell scripts..
> it doesnot recognize any tokens of the shell
> scripts..
> where cld the possible problems lie.
> i am using a cross compiler gcc for powerpc and want
> to port it
> onto the FADS board.
> thanks all
> regards
> vandana
> Give your Company an email address like
> ravi @ ravi-exports.com.  Sign up for Rediffmail Pro
> today!
> Know more. http://www.rediffmailpro.com/signup/
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
