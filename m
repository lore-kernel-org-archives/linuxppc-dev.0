Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <855be1bf81cc3629e58e6a23ebb50300@embeddededge.com>
References: <855be1bf81cc3629e58e6a23ebb50300@embeddededge.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CBF42A67-D022-4218-8624-8E40400F7C0D@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 26 Jul 2005 09:43:43 -0500
To: "Dan Malek" <dan@embeddededge.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: platform/board removal update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 26, 2005, at 9:35 AM, Dan Malek wrote:

>
> On Jul 26, 2005, at 9:01 AM, Kumar Gala wrote:
>
>
>> All the other systems (apus, gemini, rpxcllf) were more effort than I
>> was wanting to deal with.
>>
>
> Why?  The rpxcllf worked not long ago.  What happened to the  
> courtesy of
> the past when such updates were applied to all platforms such they
> would at least build?  After such changes, if there is still a  
> problem,
> the
> person should at least contact the maintainer to get it resolved.  I
> don't
> appreciate being demanded to fix something within a short period of
> time that someone else broke or else everything I've done in the past
> will be discarded.

Well, I think its reasonable amount of time.  We are talking about  
4-6 months between now and when a 2.6.15 is likely to get released.   
I'm not 100% sure who broken rpxcllf, but the issue seems to be with  
the 8xx_io/fec.c driver so it should be resolved with panto's updated  
driver.

I'm just trying to get us back into a sane state and hopefully we  
will regress building of all our defconfigs more often to catch  
things sooner.

- kumar
