Return-Path: <segher@kernel.crashing.org>
Message-ID: <61164.94.211.195.167.1301094709.squirrel@gate.crashing.org>
In-Reply-To: <4D8C47CD.3020108@ozlabs.org>
References: <4D8C47CD.3020108@ozlabs.org>
Date: Sat, 26 Mar 2011 00:11:49 +0100 (CET)
Subject: Re: [PATCH 3/5] xhci: Add rmb() between reading event validity &
	event data access.
From: "Segher Boessenkool" <segher@kernel.crashing.org>
To: "Matt Evans" <matt@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: sarah.a.sharp@linux.intel.com, linuxppc-dev@ozlabs.org,
	linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On weakly-ordered systems, the reading of an event's content must occur
> after reading the event's validity.

Put a comment on the rmb() saying what it orders?


Segher
