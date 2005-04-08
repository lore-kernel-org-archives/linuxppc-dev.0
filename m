Return-Path: <paubert@iram.es>
From: Gabriel Paubert <paubert@iram.es>
Date: Fri, 8 Apr 2005 23:44:25 +0200
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050408214425.GA17572@iram.es>
References: <20050408184442.GA13709@iram.es>
	<8497276598d775128a73efb06803a9ba@freescale.com>
	<20050408210458.GA16672@iram.es>
	<091e271750ba6ff4b07e0a9cb9f68dae@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <091e271750ba6ff4b07e0a9cb9f68dae@embeddededge.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	linux-ppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: pte_update and 64-bit PTEs on PPC32?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 08, 2005 at 05:31:43PM -0400, Dan Malek wrote:
> 
> On Apr 8, 2005, at 5:04 PM, Gabriel Paubert wrote:
> 
> >...... Loads are weekly
>                               ^^^^^^
> >ordered in general wrt each other and lwarx is no exception
> >AFAIR.
> 
> Maybe that's my performance problem :-)

Good catch ;-) 

I believe it's my funniest typo to date.

	Gabriel
