Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.236])
	by ozlabs.org (Postfix) with ESMTP id 29252DE0DC
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 16:18:18 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so23768nzh
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 22:18:17 -0700 (PDT)
Message-ID: <fa686aa40710302218s3dfe4d42red589fc5692e4c1@mail.gmail.com>
Date: Tue, 30 Oct 2007 23:18:16 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Bai Shuwei" <baishuwei@gmail.com>
Subject: Re: ring on PowerPC
In-Reply-To: <f3566d60710302205g2dd867bbk8a3494ceeda569f0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f3566d60710302205g2dd867bbk8a3494ceeda569f0@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/30/07, Bai Shuwei <baishuwei@gmail.com> wrote:
> Hi, everyone
>    As we know, the program on the X86 can run on the differnt ring(0, 1, 2,
> 3) and the linux kernel run in the ring 0 and user program in the ring 3.
> And now I want to know wether there is a simple mechanism on the PowerPC
> architecture? thx all!

Powerpc has 2 privilege levels; user and supervisor.  The kernel runs
in supervisor mode, and user-space runs in user mode.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
