Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp12.wanadoo.fr (smtp12.wanadoo.fr [193.252.22.20])
	by ozlabs.org (Postfix) with ESMTP id ABDCF67A6D
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Mar 2005 03:13:50 +1100 (EST)
Date: Fri, 18 Mar 2005 16:59:05 +0100
To: "Brian V. Madzarevic" <Brian.Madzarevic@uav.com>
Message-ID: <20050318155904.GA8630@pegasos>
References: <A79EE6739F2C7348A857541FB5CD92D6011566F6@asimail1.rb.uav.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <A79EE6739F2C7348A857541FB5CD92D6011566F6@asimail1.rb.uav.com>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: 2.6.11 prep image on radstone ppc4a not booting
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 08, 2005 at 10:11:31AM -0800, Brian V. Madzarevic wrote:
> I am trying to boot a Linux 2.6.11 prep image on a Radstone PPC4A.
> PPC4A Specifications http://www.radstone.com/rtcd/pdfs/ppc4a.pdf

Did it use to work with older kernels ? 

This may be another problem of badly specified irqs like we had with the
motorola powerstacks. See the mailing list archive about this issues.

Friendly,

Sven Luther
