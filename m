Return-Path: <frannk_m1@yahoo.com>
Received: from web32201.mail.mud.yahoo.com (web32201.mail.mud.yahoo.com
	[68.142.207.132]) by ozlabs.org (Postfix) with SMTP id 55FDDDDE1F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 May 2008 12:20:07 +1000 (EST)
Date: Wed, 14 May 2008 19:13:27 -0700 (PDT)
From: Frank <frannk_m1@yahoo.com>
Subject: Re: How to test the DDR memory with burst visit mode?
To: "¹ù¾¢" <guojin02@tsinghua.org.cn>, linuxppc-embedded@ozlabs.org
In-Reply-To: <410764342.21662@tsinghua.org.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <163586.166.qm@web32201.mail.mud.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--- ¹ù¾¢ <guojin02@tsinghua.org.cn> wrote:

> Hi,friends,
>    I designed my MPC8360E board with 1GBytes DDR-1 memory, I
> built two demo
> boards, one is 533/266/400, the other is 660/330/400. The
> lower frequancy board is
> no problem for our program, but the higher frequency board is
> always problem about
> the data transmit on ethernet. 
>    I want to test 1GBytes DDR-1 memory, I want to know whether
> or not the DDR is
> stable and accuracy. Could you tell me a simple way that test
> my DDR memory? 
> 
Boot the kernel and run something like stress from LTP (Linux
Test project). I guarantee you if there is any instability it
will show up...



      
