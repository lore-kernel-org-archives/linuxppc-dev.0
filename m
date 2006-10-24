Return-Path: <fawadlateef@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.239])
	by ozlabs.org (Postfix) with ESMTP id 4FF04679F0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Oct 2006 22:14:05 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id t14so2156179wxc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Oct 2006 05:14:04 -0700 (PDT)
Message-ID: <1e62d1370610240514v261e4366j43ff2778555fa7f5@mail.gmail.com>
Date: Tue, 24 Oct 2006 17:14:03 +0500
From: "Fawad Lateef" <fawadlateef@gmail.com>
To: Rahul <rahul.theraja@gmail.com>
Subject: Re: help in block drivers
In-Reply-To: <ff9652ca0610240237j4c4c3733l15b873890bd56d42@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <ff9652ca0610190314u32a620b5qd0bd27a1b2700a22@mail.gmail.com>
	<d16b1c80610190808y17c516dl35cfc8ca4a7a42ad@mail.gmail.com>
	<ff9652ca0610190923vffbb981j1978ce4159489b0c@mail.gmail.com>
	<1e62d1370610192213g7502709ufcc2bce6903040d8@mail.gmail.com>
	<ff9652ca0610220202w4b0d831bu202ccff8ed941f2d@mail.gmail.com>
	<ff9652ca0610240237j4c4c3733l15b873890bd56d42@mail.gmail.com>
Cc: kernelnewbies@nl.linux.org, Shakthi Kannan <shakthimaan@gmail.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 10/24/06, Rahul <rahul.theraja@gmail.com> wrote:
>
>  Can anyone tell me or send me some links that tells about the following
> functions:
>  daemonize, siginitsetinv , recalc_sigpending . Though i googled, i coildnt
> get much information on them.
>

daemonize() -----> is used to make kernel thread without any
user-space resources and in the last it makes thread/process child of
init. see comments above function definition
(http://lxr.free-electrons.com/source/kernel/exit.c#373)


For understanding these sort of functions, just look for kernel_thread
documents on google and there you will find details. You can also get
information in comments above these functions definition. OR do search
for their usage in other places in kernel's code and you will get the
information related to that required function.


>  Thanks in adavance
>  Rahul
>
>


-- 
Fawad Lateef
