Return-Path: <dale@farnsworth.org>
Date: 23 Oct 2007 14:40:00 -0700
Message-ID: <20071023214000.424.qmail@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: vbarshak@ru.mvista.com, Linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] PowerPC 440EPx Sequoia USB OHCI DTS entry
In-Reply-To: <471E2CDA.1080301@ru.mvista.com>
References: <20071008142658.GA15197@ru.mvista.com>
	<e1b19c12c7006e763a56627fa9a05ec9@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Valentine wrote:
> Actually I also don't see much reason for the 
> USB_OHCI_HCD_PPC_OF_BE/USB_OHCI_HCD_PPC_OF_LE stuff.
> Is this really needed?

I think so.  The SOC host controllers are BE and the PCI
host controllers are LE.  Or, do you have an alternative
method of handling both types?

-Dale
