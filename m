Return-Path: <dgibson@ozlabs.org>
Date: Wed, 30 Jun 2010 10:46:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: kernel init exception
Message-ID: <20100630004633.GB12417@yookeroo>
References: <AANLkTimV1AFEUrRf-2iEizXH4HQFMrrAumsRVDKxNfAv@mail.gmail.com>
	<356261A9-B09F-4E82-A897-FD0724C503F4@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <356261A9-B09F-4E82-A897-FD0724C503F4@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"wilbur.chan" <wilbur512@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 29, 2010 at 06:51:16PM +0200, Segher Boessenkool wrote:
> >why there generated a signal 4  in  init  process?
> 
> That's SIGILL; sounds like you compiled init with the wrong (sub-)arch
> or cpu flags.

Or it's been corrupted during load.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
