Return-Path: <dan@embeddedalley.com>
Received: from smtp105.biz.mail.mud.yahoo.com (smtp105.biz.mail.mud.yahoo.com
	[68.142.200.253]) by ozlabs.org (Postfix) with SMTP id C9BB8DDE32
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Jun 2007 05:42:10 +1000 (EST)
In-Reply-To: <467C06B8.6070303@certicom.com>
References: <467C06B8.6070303@certicom.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AC13379B-60F2-4F76-A2F8-275285E92B0A@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: Memory coherency on MPC8272
Date: Fri, 22 Jun 2007 12:35:36 -0700
To: Dmitri Petchkine <dpetchkine@certicom.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 22, 2007, at 10:28 AM, Dmitri Petchkine wrote:

> My understanding that the security hardware of MPC8272 uses DMA to  
> write
> results into the memory which may cause a coherency problem.

Where did you get such an (incorrect) understanding?
I suggest you acquire your understanding from reading the
MPC8272 reference manual, since it describes the cache
and snooping options between the SEC and memory,
as well as among the SEC units.

> My exposure to such hardware issues is very limited, so I  
> appreciate any
> advice on how to fix it.

The code snippet clearly shows you don't understand
the user/kernel interface, since your access to "param" isn't
correct.  The SEC is complex and has subtle control
considerations, any part of this could be incorrect.  I
suspect your coding errors are hidden/highlighted
by adding the code for the printing, not the actual
operation itself.


	-- Dan
