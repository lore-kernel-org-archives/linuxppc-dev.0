From: Thomas Graichen <news-innominate.list.linux.ppc.dev@innominate.de>
Reply-To: Thomas Graichen <graichen@innominate.de>
Subject: Re: keyboard problems
Date: 4 Aug 2000 12:31:41 GMT
Message-ID: <news2mail-8med3d$ch4$4@mate.bln.innominate.de>
References: <news2mail-8m5oaq$6tj$3@mate.bln.innominate.de> <14729.3700.660339.484633@argo.linuxcare.com.au>
Reply-To: thomas.graichen@innominate.de
To: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras <paulus@linuxcare.com.au> wrote:

> Thomas Graichen writes:
>>
>> i have a little keyboard problem on my blueberry imac with the
>> standard usb keyboard: whenever i type something very quickly
>> followed by space the typed in will be repeated before the
>> space (best example: i want to type "cd " and get "cdcd ")
>> - this gets a bit annoying - does anybody have the same
>> problem (or even a fix for it) ? - is it more a soft-
>> wareproblem (i hope :-) or maybe a hardwareproblem ?
>> (i had it on all kernels from 2.2.x to 2.4.0-testx)

> It's simply a bug in the USB keyboard driver.  It just means that the
> driver isn't coping with the "overflow" code that the keyboard sends
> when it has too many keys depressed at once.

any chance of this getting fixed in the next time ? - any patch
around to try ? (because it's close to unuseable for me this
way :-)

t

--
thomas.graichen@innominate.de
Technical Director                                       innominate AG
Clustering & Security                                networking people
tel: +49.30.308806-13  fax: -77                   http://innominate.de

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
