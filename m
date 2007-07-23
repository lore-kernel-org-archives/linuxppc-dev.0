Return-Path: <timur@freescale.com>
Message-ID: <46A4A92C.5040708@freescale.com>
Date: Mon, 23 Jul 2007 08:12:12 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
Subject: Re: [PATCH 3/4] mpc8349emitx: Add chosen node for default stdout path
References: <20070719183415.7458.42622.stgit@trillian>	<20070719183734.7458.83695.stgit@trillian>	<469FB47D.4030009@freescale.com>	<fa686aa40707191243wb4ce9c1n86002405c5d01bab@mail.gmail.com>	<20070719164036.f3d4c86d.kim.phillips@freescale.com>	<469FDB3B.5000901@freescale.com>
	<46A01733.6080609@gmail.com>
In-Reply-To: <46A01733.6080609@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jerry Van Baren wrote:

> The "force" parameter was added to sort of emulate the previous bootm 
> command behavior (but behave better in the case where /chosen already 
> existed).

I don't think the previous bootm behavior was ever desirable.  In fact, I think most people didn't realize that bootm used to create an additional /chosen section if one was in the DTS, and the only reason it worked was because the kernel picked the right one.  IMHO, I think you can safely remove the 'force' parameter and change to code to match "force==true", and no one will care.

I believe all of the DTS files have already been scrubbed of their /chosen section, so "force" doesn't matter with any recent DTS.
