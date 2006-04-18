Return-Path: <will_schmidt@vnet.ibm.com>
Subject: Re: [PATCH] Remove stale iseries global
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20060418162553.GC26746@pb15.lixom.net>
References: <20060418162553.GC26746@pb15.lixom.net>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 12:31:14 -0500
Message-Id: <1145381474.20493.5.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-04-18 at 11:25 -0500, Olof Johansson wrote:
> Hi,
> 
> Not even the iSeries maintainer seems to have access to this legendary
> piranha simulator. It adds a bit of ugliness in the common time init
> code, and if it's no longer used we might as well be done with it and
> remove the bloat.
> 

Yes, the piranha tools are no longer used with linux.   I see no reason
why this needs to stay.  


> Signed-off-by: Olof Johansson <olof@lixom.net>
> 

Acked-by: Will Schmidt   willschm@us.ibm.com
