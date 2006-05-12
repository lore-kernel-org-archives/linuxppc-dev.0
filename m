Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from agrxsusmail.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id 93D73679F7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 May 2006 22:56:24 +1000 (EST)
Message-ID: <44647EE7.2020205@smiths-aerospace.com>
Date: Fri, 12 May 2006 08:26:15 -0400
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
Subject: Re: [U-Boot-Users] Re: Failure of 2 BAT schemes to enable D-cache
References: <20060511223814.2195C352B0C@atlas.denx.de>
In-Reply-To: <20060511223814.2195C352B0C@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "U-Boot-Users@lists.sourceforge.net" <U-Boot-Users@lists.sourceforge.net>,
	"linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Wolfgang Denk wrote:
> In message <20060511201329.23866.qmail@web37105.mail.mud.yahoo.com> you wrote:
>> Please post comments and suggestions of how I can
>> initialized MMU for d-cache performance. I am  new
>> to this.
> 
> We have been through this before, several times. Many times actually.
> I have explained it to you, and so did others.
> 
> It is perfectly fine with me if you ignore my advice. But then please
> stop posting the same question again and again here.
> 
> You will not receive any new answers.
> 
> Again, and definitely for the last time:
> 
> It makes no sense to try to enable the data cache on a MPC82xx system
> in U-Boot; the time you could save if you succeeded  is  marginal  to
> your application startup time.
> 
> And in Linux the D-Cache is enabled, so no changes are needed.
> 
> 
> Best regards,
> Wolfgang Denk

Furthermore, manipulating processor control registers interactively with 
a debugger (e.g. attempting to enable dcache) is somewhere between 
nearly impossible and totally impossible.  Read and understand the 
processor manual on the sequences required for changing control 
registers and enabling/disabling cache.  You cannot guarantee that the 
sequences will be done properly because the debugger has LOTS of unknown 
code running to implement what to you "looks like" a simple register 
write command.

Signing off on this thread,
gvb
