Return-Path: <benh@kernel.crashing.org>
Subject: Re: Fw: [PATCH 2/15] Automatically lmb_reserve() initrd
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Winiecki <stevewin@us.ibm.com>
In-Reply-To: <OF526C2D02.381593EB-ON8725729D.005FC841-8525729D.0060FE86@us.ibm.com>
References: <OF526C2D02.381593EB-ON8725729D.005FC841-8525729D.0060FE86@us.ibm.com>
Content-Type: text/plain
Date: Tue, 13 Mar 2007 19:00:55 +0100
Message-Id: <1173808855.24454.80.camel@localhost.localdomain>
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


> I understand - I guess I am just thinking of the case where someone didn't 
> define the property because they were not aware of it - esp in this case 
> where the existence of the property name is all that is required for the 
> value to be filled in properly by the init code.  Instead of just setting 
> the start/end to 0 - maybe include a message something like (even if 
> debug) "No initird-start/end property found - setting to 0" - just a minor 
> example.  The larger point also being that defining dts files and 
> properties may be a new thing for many people with the new support - might 
> be helpful to surface missing properties when appropriate (I'm not 
> condoning mass amounts of messages for everything). 

I think the proper thing to do instead is improve the documentation :-)

Ben.
