Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 246BFDDF01
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 15:22:38 +1100 (EST)
Date: Wed, 30 Jan 2008 22:22:48 -0600
From: Olof Johansson <olof@lixom.net>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: build error with kdump shutdown hook support
Message-ID: <20080131042248.GA31344@lixom.net>
References: <47A13EEB.8030806@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47A13EEB.8030806@am.sony.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 30, 2008 at 07:22:19PM -0800, Geoff Levand wrote:
> Hi.
> 
> It seems something is missing in the current
> linux-2.6.git (8af03e782cae1e0a0f530ddd22301cdd12cf9dc0).

See:

http://patchwork.ozlabs.org/linuxppc/patch?id=16607

Or add a separate handler instead of reusing the debugger one, either
way works for me. I went with the easier option.

-Olof
