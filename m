Return-Path: <michael@ellerman.id.au>
Date: Tue, 23 Apr 2013 12:49:51 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v3 12/12] Add /proc interface to control topology updates
Message-ID: <20130423024951.GA20902@concordia>
References: <51757951.2080007@linux.vnet.ibm.com>
 <517585DB.9040603@linux.vnet.ibm.com>
 <20130423120026.85860c95d1c82582fa9a6ef5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130423120026.85860c95d1c82582fa9a6ef5@canb.auug.org.au>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 23, 2013 at 12:00:26PM +1000, Stephen Rothwell wrote:
> Hi Nathan,
> 
> On Mon, 22 Apr 2013 13:47:55 -0500 Nathan Fontenot <nfont@linux.vnet.ibm.com> wrote:
> >
> >  #if defined(CONFIG_NUMA) && defined(CONFIG_PPC_SPLPAR)
> >  extern int start_topology_update(void);
> >  extern int stop_topology_update(void);
> > +extern inline int prrn_is_enabled(void);
> 
> You really can't do "extern inline" with no body ...

No you can't, and at least with my compiler it causes a build error.

cheers
