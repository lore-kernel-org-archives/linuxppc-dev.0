Message-Id: <200110111256.f9BCuuf07110@ashley.ivey.uwo.ca>
Date: Thu, 11 Oct 2001 08:53:25 -0400
From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Content-Type: text/plain;
	format=flowed;
	charset=us-ascii
Subject: Re: bug in XFree86 4.1.0 with Rage 128 driver?
Cc: =?iso-8859-1?Q?Michel_D=E4nzer?= <michdaen@iiic.ethz.ch>,
	linuxppc-dev@lists.linuxppc.org, Herbert Duerr <duerr@sun.com>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20011011134940.A3720@suse.de>
Mime-Version: 1.0 (Apple Message framework v388)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi All.

>> I don't feel qualified to do that. Xpert@XFree86.Org is a mailing list
>> which
>> the author of this code and other very competent XFree86 hackers read,
>> or if
>> you're absolutely sure the fix is correct, please submit it to
>> fixes@XFree86.Org .

Michel:

I just don't see how using an uninitialized variable in an "if"
statement can be anything else but a bug.  You could have at least
looked at the code in question before replying.  You are a member of
XFree representing ppc linux aren't you?  I assumed with your signature
and your earlier responses, you were the right person to contact.  If
not, I apologize for bothering you.

> keithp already put something in the CVS. It did not work with "ati", but
> with fbdev (clgen).
> The patch fixed it for me on the Pismo.

Thanks Olaf,

Glad to see it helped and is in CVS.

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
