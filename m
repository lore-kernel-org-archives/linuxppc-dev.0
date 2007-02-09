Return-Path: <dan@embeddedalley.com>
Received: from smtp105.biz.mail.re2.yahoo.com (smtp105.biz.mail.re2.yahoo.com
	[206.190.52.174]) by ozlabs.org (Postfix) with SMTP id 5E702DDED4
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 04:26:12 +1100 (EST)
In-Reply-To: <45CAF4C4.7030002@karel.com.tr>
References: <45CAF4C4.7030002@karel.com.tr>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <50CB27D3-ACF9-47E9-8690-95B76391F18C@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: Mpc875 Ethernet does not work under linux.
Date: Fri, 9 Feb 2007 12:26:08 -0500
To: Cem Vedat ISIK <cem.isik@karel.com.tr>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	ppc embedded list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 8, 2007, at 5:00 AM, Cem Vedat ISIK wrote:

> I'm having a problem using ethernet with denx-provided kernel:
> linuxppc_2_4_devel-2006-04-06-1735 on mpc875 (a member of mpc885  
> family).

Sounds like you didn't properly port your
kernel.  I use both 2.4 and 2.6 on 875 and 885
every day.  Works fine.  Take a look at your
clock routing and PHY support functions to
ensure that's all correct.


	-- Dan
