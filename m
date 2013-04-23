Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DB18D2C00EF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 04:59:41 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 23 Apr 2013 14:59:38 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 7A6F438C8029
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 14:59:36 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3NIxavV290808
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 14:59:36 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3NIxZaN000507
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 15:59:36 -0300
Message-ID: <5176DA0D.9070801@linux.vnet.ibm.com>
Date: Tue, 23 Apr 2013 13:59:25 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH v3 12/12] Add /proc interface to control topology updates
References: <51757951.2080007@linux.vnet.ibm.com>
 <517585DB.9040603@linux.vnet.ibm.com>
 <20130423120026.85860c95d1c82582fa9a6ef5@canb.auug.org.au>
 <20130423024951.GA20902@concordia>
In-Reply-To: <20130423024951.GA20902@concordia>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/22/2013 09:49 PM, Michael Ellerman wrote:
> On Tue, Apr 23, 2013 at 12:00:26PM +1000, Stephen Rothwell wrote:
>> Hi Nathan,
>>
>> On Mon, 22 Apr 2013 13:47:55 -0500 Nathan Fontenot <nfont@linux.vnet.ibm.com> wrote:
>>>
>>>  #if defined(CONFIG_NUMA) && defined(CONFIG_PPC_SPLPAR)
>>>  extern int start_topology_update(void);
>>>  extern int stop_topology_update(void);
>>> +extern inline int prrn_is_enabled(void);
>>
>> You really can't do "extern inline" with no body ...
> 
> No you can't, and at least with my compiler it causes a build error.
> 

Easy enough, no more inline for this.

This for looking,
-Nathan
