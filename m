Return-Path: <martyn.welch@ge.com>
Received: from exprod5og104.obsmtp.com (exprod5og104.obsmtp.com [64.18.0.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D22BCB7CCD
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2010 22:50:21 +1100 (EST)
Message-ID: <4B87B5A4.2010106@ge.com>
Date: Fri, 26 Feb 2010 11:51:00 +0000
From: Martyn Welch <martyn.welch@ge.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: Gianfar driver failing on MPC8641D based board
References: <4B6C2488.3060403@ge.com> <4B865176.7080806@ge.com>
	<4B86A97E.6050509@ge.com>
	<20100225165141.GA9686@oksana.dev.rtsoft.ru>
In-Reply-To: <20100225165141.GA9686@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Sandeep Gopalpet <Sandeep.Kumar@freescale.com>, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> On Thu, Feb 25, 2010 at 04:46:54PM +0000, Martyn Welch wrote:
> [...]
>   
>>> nfs: server 192.168.0.1 not responding, still trying
>>>   
>>>       
>> Further testing has shown that this isn't restricted to warm reboots, it
>> happens from cold as well. In addition, the exact timing of the failure
>> seems to vary, some boots have got further before failing.
>>     
>
> Unfortunately I don't have any 8641 boards near me, so I can't
> debug this myself. Though, I tested gianfar on MPC8568E-MDS with
> 2.6.33 kernel, and it seems to work just fine.
>
> I see you use SMP. Can you try to turn it off? If that will fix
> the issue, then it'll be a good data point.
>
> Meanwhile, I'll try SMP kernel on MPC8568 (UP), and let you
> know the results.
>
> Thanks

I removed the second core from the dts file rather than truly disabling
SMP in the kernel config. Doing this allowed the board to boot reliably.

Martyn

-- 
Martyn Welch (Principal Software Engineer)   |   Registered in England and
GE Intelligent Platforms                     |   Wales (3828642) at 100
T +44(0)127322748                            |   Barbirolli Square, Manchester,
E martyn.welch@ge.com                        |   M2 3AB  VAT:GB 927559189
