Return-Path: <xiaoxianghua@gmail.com>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by ozlabs.org (Postfix) with ESMTP id 03776B70CE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 13 Aug 2010 12:18:30 +1000 (EST)
Received: by qwj9 with SMTP id 9so2287667qwj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 Aug 2010 19:18:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C64352F.4090005@theptrgroup.com>
References: <AANLkTikrpqFQsK=YLkHeWc1ZC=_Gz2rWStJrbQ8O-SrZ@mail.gmail.com>
	<4C64352F.4090005@theptrgroup.com>
Date: Thu, 12 Aug 2010 21:18:27 -0500
Message-ID: <AANLkTinmBH6BV9qgvekiJgQFw1T5j8DeFOcdoTUnFsLw@mail.gmail.com>
Subject: Re: Query regarding 2.6.335 RT[Ingo's] and Non-RT performance
From: Xianghua Xiao <xiaoxianghua@gmail.com>
To: Jeff Angielski <jeff@theptrgroup.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 12, 2010 at 12:53 PM, Jeff Angielski <jeff@theptrgroup.com> wro=
te:
> On 08/11/2010 06:18 PM, Manikandan Ramachandran wrote:
>>
>> Hello All,
>> =C2=A0 =C2=A0 I created a very simple program which has higher priority =
than
>> normal tasks and runs a tight loop. Under same test environment I ran
>> this program on both non-rt and rt 2.6.33.5 kernel. =C2=A0To my suprise =
I see
>> that performance of non-RT kernel is better than RT. non-RT kernel took
>> 3 sec and 366156 usec while RT kernel took about 3 sec and 418011
>> usec.Can someone please explain why the performance of non-rt kernel is
>> better than rt kernel? From the face of the test result, I feel RT has
>> more overhead,Is there any configuration that I could do to bring down
>> the overhead?
>
> Your "surprise" is due to your definition of "performance".
>
> The purpose of the -rt kernels is to reduce the kernel latency. =C2=A0Thi=
s is
> important for servicing hardware. =C2=A0Normal users find the -rt useful =
for
> audio/video applications. =C2=A0Engineering and scientific users find the=
 -rt
> beneficially for servicing hardware like sensors or control systems.
>
> If you are just trying to run calculations as fast as you can in user spa=
ce,
> you'd be better off using the non-rt variants.
>
>
> --
> Jeff Angielski
> The PTR Group
> www.theptrgroup.com
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>

true, in most cases non-rt will have better performance/throughput,
while rt's major goal is to have better latency for high priority
tasks. also true is that, rt kernel will have more overhead.

xianghua
