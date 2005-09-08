Return-Path: <dan@embeddededge.com>
In-Reply-To: <39A39EEE-E3B1-4D34-BC6E-854C3EF56C7D@freescale.com>
References: <f2ea45e1b2a9689c450811a61ed46183@embeddededge.com>
	<39A39EEE-E3B1-4D34-BC6E-854C3EF56C7D@freescale.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1f573d932fdab43ce4e4a0a918c5d9df@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 8 Sep 2005 18:20:47 -0400
To: Kumar Gala <kumar.gala@freescale.com>
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
	linuxppc-embedded@ozlabs.org, pantelis.antoniou@gmail.com
Subject: Re: cpu features testing 32 vs 64 bit
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 8, 2005, at 6:02 PM, Kumar Gala wrote:

> The compiler is smart enough in this case since cpu_has_feature() is 
> an inline function.

I guess I didn't read Becky's comments close enough, but she did
suggest this.  I was trying to eliminate the #ifdef, but I guess we will
need it some place.

Thanks.

	-- Dan
