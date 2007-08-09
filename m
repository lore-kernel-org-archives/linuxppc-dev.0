Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id B8147DDE99
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 11:02:43 +1000 (EST)
Date: Wed, 8 Aug 2007 20:02:24 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 6/6] pseries: eliminate global var
Message-ID: <20070809010224.GE10114@localdomain>
References: <20070808195916.GA20055@austin.ibm.com>
	<20070808200115.GA20134@austin.ibm.com>
	<20070808200210.GB20134@austin.ibm.com>
	<20070808200337.GC20134@austin.ibm.com>
	<20070808200448.GD20134@austin.ibm.com>
	<20070808200615.GE20134@austin.ibm.com>
	<20070808200713.GF20134@austin.ibm.com>
	<20070808215714.GB10114@localdomain>
	<20070808222223.GH25995@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070808222223.GH25995@austin.ibm.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas wrote:
> On Wed, Aug 08, 2007 at 04:57:14PM -0500, Nathan Lynch wrote:
> > Linas Vepstas wrote:
> > > +
> > > +#ifdef CONFIG_PPC_PSERIES
> > > +extern int pSeries_nvram_init(void);
> > > +extern int nvram_write_error_log(char * buff, int length,
> > > +					 unsigned int err_type, unsigned int err_seq);
> > > +extern int nvram_read_error_log(char * buff, int length,
> > > +					 unsigned int * err_type, unsigned int *err_seq);
> > > +extern int nvram_clear_error_log(void);
> > > +#endif /* CONFIG_PPC_PSERIES */
> > 
> > Declarations need not be #ifdef'd.
> 
> Ah, I thought that would be cleaner ... should I resubmit,
> the patch, or does it matter that much?

FWIW I'd prefer you drop that hunk and resubmit; it's needless churn
that can only cause build problems.
