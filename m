From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: Eric Ding <ericding@applix.com>
Subject: Re: ld bug with -Bsymbolic --noinhibit-exec (2.9.1.0.990418-1c)
Date: Wed, 16 Jun 1999 22:40:31 +0200
Content-Type: text/plain
Cc: linuxppc-dev@lists.linuxppc.org
References: <199906161938.PAA10763@tuxedo.applix.com>
MIME-Version: 1.0
Message-Id: <99061622444300.00949@ns1102.munich.netsurf.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Am Mit, 16 Jun 1999 schrieb Eric Ding:
>Hi Franz,
>
>>>>>> Franz Sirl <Franz.Sirl-kernel@lauterbach.com> writes:
>
>> Ok, would you mind trying binutils-2.9.4.0.5 on Intel too? It's
>> available on <ftp://ftp.varesearch.com/pub/support/hjl/binutils/beta>
>> as a RPM.
>
>> I'm trying to sort out if this is related to newer binutils or if it's
>> PPC specific.
>
>just noticed I called you Frank last time.  Sorry 'bout that.  :)

no problem :-). I didn't even notice...

>I had a co-worker test out the Intel 2.9.4.0.5 binutils and it worked
>without a problem on that hardware platform.

Hmm, I browsed thru the binutils code and didn't see anything suspicious. Is
there any chance you can strip that down to a small testcase with a few
symbols? That would help debugging a lot.

>> BTW, I'm "franzo" on #mklinux/EFNet for even faster feedback :-)
>
>I don't have irc access from work (this is irc, right?)...

Yes, irc.

Franz.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
