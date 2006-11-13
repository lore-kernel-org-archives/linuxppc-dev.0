Return-Path: <kallepokki@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.206])
	by ozlabs.org (Postfix) with ESMTP id A899267DB1
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Nov 2006 22:01:58 +1100 (EST)
Received: by nz-out-0102.google.com with SMTP id v1so764387nzb
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Nov 2006 03:01:58 -0800 (PST)
Message-ID: <a425f86c0611130301p13d4cb74w76edc8f3b333750@mail.gmail.com>
Date: Mon, 13 Nov 2006 13:01:56 +0200
From: "Kalle Pokki" <kalle.pokki@iki.fi>
Sender: kallepokki@gmail.com
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: [PATCH] CPM_UART: Fix non-console initialisation (v2)
In-Reply-To: <17752.16589.182362.143760@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <Pine.LNX.4.64.0611011457490.3387@host32.eke.fi>
	<17748.21645.621069.105453@cargo.ozlabs.ibm.com>
	<a425f86c0611100345h40b104cchdb766e35f1767656@mail.gmail.com>
	<Pine.LNX.4.64.0611101359200.25024@host32.eke.fi>
	<17749.46096.241328.470093@cargo.ozlabs.ibm.com>
	<20061113112230.4c1af7b0@localhost.localdomain>
	<17752.16589.182362.143760@cargo.ozlabs.ibm.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/13/06, Paul Mackerras <paulus@samba.org> wrote:
> Well, what I want to know is this: why was the addition of __init
> bundled in with what I was told was a bug-fix that was needed for
> 2.6.19?  Does the addition of __init fix a bug somehow?

That wasn't necessary, but the change was so small I thought we could
just as well do it at the same time when touching this function
anyway. (Although the second version of the patch didn't modify it
anymore, thus making the part adding __init actually larger in the
patch than the part having the bugfix.)
