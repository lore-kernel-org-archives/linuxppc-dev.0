Return-Path: <linas@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6BA29DDEC8
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 08:22:28 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l78MMOK7013788
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 18:22:24 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l78MMOId394058
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 18:22:24 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l78MMO34003993
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 18:22:24 -0400
Date: Wed, 8 Aug 2007 17:22:23 -0500
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH 6/6] pseries: eliminate global var
Message-ID: <20070808222223.GH25995@austin.ibm.com>
References: <20070808195916.GA20055@austin.ibm.com>
	<20070808200115.GA20134@austin.ibm.com>
	<20070808200210.GB20134@austin.ibm.com>
	<20070808200337.GC20134@austin.ibm.com>
	<20070808200448.GD20134@austin.ibm.com>
	<20070808200615.GE20134@austin.ibm.com>
	<20070808200713.GF20134@austin.ibm.com>
	<20070808215714.GB10114@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070808215714.GB10114@localdomain>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 08, 2007 at 04:57:14PM -0500, Nathan Lynch wrote:
> Linas Vepstas wrote:
> > +
> > +#ifdef CONFIG_PPC_PSERIES
> > +extern int pSeries_nvram_init(void);
> > +extern int nvram_write_error_log(char * buff, int length,
> > +					 unsigned int err_type, unsigned int err_seq);
> > +extern int nvram_read_error_log(char * buff, int length,
> > +					 unsigned int * err_type, unsigned int *err_seq);
> > +extern int nvram_clear_error_log(void);
> > +#endif /* CONFIG_PPC_PSERIES */
> 
> Declarations need not be #ifdef'd.

Ah, I thought that would be cleaner ... should I resubmit,
the patch, or does it matter that much?

--linas
