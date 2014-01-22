Return-Path: <anton@samba.org>
Date: Wed, 22 Jan 2014 21:42:47 +1100
From: Anton Blanchard <anton@samba.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 8/8] powerpc: Fix endian issues in crash dump code
Message-ID: <20140122214247.4ef64d90@kryten>
In-Reply-To: <1387341927.20735.1.camel@concordia>
References: <1386824381-14032-1-git-send-email-anton@samba.org>
 <1386824381-14032-9-git-send-email-anton@samba.org>
 <1387341927.20735.1.camel@concordia>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, Ulrich.Weigand@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Michael,
 
> Not my favourite colour :D  What about this instead?
> 
> We could also add of_property_read_u32(), with an implied index of
> zero?
> 
> I don't like the rc handling, but couldn't come up with anything I
> liked better.

Thanks for pointing that out, I didn't realise we had so many
of_property_read_* helpers. I'll be sure to use them from here on :)

Anton
