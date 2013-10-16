Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2F5E92C00E3
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Oct 2013 02:28:15 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 16 Oct 2013 09:28:14 -0600
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 9D9DBC9006A
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 11:28:07 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9GFS6W357933996
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 15:28:06 GMT
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r9GFS5VE005077
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 12:28:06 -0300
Date: Wed, 16 Oct 2013 08:27:42 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH 02/10][v6] powerpc/Power7: detect load/store instructions
Message-ID: <20131016152742.GB25073@us.ibm.com>
References: <1381889202-16826-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1381889202-16826-3-git-send-email-sukadev@linux.vnet.ibm.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B738E@saturn3.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B738E@saturn3.aculab.com>
Cc: Michael Ellerman <michaele@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Laight [David.Laight@aculab.com] wrote:
| 
| I can't help feeling the code could do with some comments about
| which actual instructions are selected where.

At a high level, only the load and store instructions are selected.

I added a reference to the Appendix F (Opcode maps) in the function
header.  The opcode maps is a table of upper x lower values. From
that table it should be fairly straightforward which instructions
are selected.

How about I add this to the function header ?

 * Please use the table in Appendix F (opcode maps) to determine
 * events selected by this function.

There are over 100 instructions selected by this list and wasn't
sure if we should list them all.

Sukadev
