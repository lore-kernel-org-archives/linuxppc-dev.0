Return-Path: <dhbaird@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id 54FAEDDDF2
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Jan 2008 18:55:20 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so3645180wag.13
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 20 Jan 2008 23:55:19 -0800 (PST)
Message-ID: <440abda90801202355m1f1ccdafw9c2f1333498fa48c@mail.gmail.com>
Date: Mon, 21 Jan 2008 00:55:18 -0700
From: "David Baird" <dhbaird@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Xilinx XPS_LL_TEMAC vs PLB_TEMAC
In-Reply-To: <BAY115-W17ECE16AB6FA79B2D4DBBDB23D0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <BAY115-W17ECE16AB6FA79B2D4DBBDB23D0@phx.gbl>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Jan 21, 2008 12:36 AM, Mohammad Sadegh Sadri <mamsadegh@hotmail.com> wrote:
> As you know Xilinx PLB TEMAC is a module which connects Hard TEMAC in
> Virtex-4 FX devices to PLB bus,
> now, in the new release of EDK , EDK 9.2 Xilinx has added a new interface
> core , which is called XPS_LL_TEMAC and has a different structure than
> normal PLB TEMAC. spacially it has some additional data transfer buses.
>
> Now the question is,... is there any linux driver available for this new
> core?

Yes there is, but I had to use the git sources at:

git.xilinx.com
