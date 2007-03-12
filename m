Return-Path: <benh@kernel.crashing.org>
Subject: Re: Fw: [PATCH 2/15] Automatically lmb_reserve() initrd
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Winiecki <stevewin@us.ibm.com>
In-Reply-To: <OF0BE55B3C.650D62FC-ON8725729C.006DDB97-8525729C.006F8642@us.ibm.com>
References: <OF0BE55B3C.650D62FC-ON8725729C.006DDB97-8525729C.006F8642@us.ibm.com>
Content-Type: text/plain
Date: Mon, 12 Mar 2007 22:25:32 +0100
Message-Id: <1173734732.24454.52.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> It might be helpful if some kind of message was surfaced if the 
> initrd-start/end properties didn't exist in the dt, esp. since it may not 
> be well known initially as a dts definition requirement/option (voice of 
> experience :)).  In general I think surfacing messages for any properties 
> which are detected as not existing and which might be normally expected 
> would be a good thing as people get familiar with defining dts files and 
> specifying properties for their platforms. 

Well.. initrd is totally optional...

Ben.
