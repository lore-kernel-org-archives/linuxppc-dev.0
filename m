Return-Path: <jacmet@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.206])
	by ozlabs.org (Postfix) with ESMTP id 8B1A068A42
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Feb 2006 19:09:19 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 50so326670wri
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 02 Feb 2006 00:09:18 -0800 (PST)
Message-ID: <9305ca410602020009r4946d874qc52c2b27f715370f@mail.gmail.com>
Date: Thu, 2 Feb 2006 09:09:17 +0100
From: Peter Korsgaard <jacmet@sunsite.dk>
Sender: jacmet@gmail.com
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Yosemite/440EP why are readl()/ioread32() setup to
	readlittle-endian?
In-Reply-To: <Pine.LNX.4.44.0602011851490.22854-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <87wtgeeq8o.fsf@48ers.dk>
	<Pine.LNX.4.44.0602011851490.22854-100000@gate.crashing.org>
Cc: linuxppc-embedded@ozlabs.org, "Jenkins, Clive" <Clive.Jenkins@xerox.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 2/2/06, Kumar Gala <galak@kernel.crashing.org> wrote:
> > What is the preferred way of accessing non-PCI devices then? Direct
> > pointer access?
>
> No direct pointer access is bad. On PPC You can use
> in_be{8,16,32}/out_be{8,16,32}

What about arch independent drivers? Are there any generic approach
for this or do you have to stick to ugly #ifdefs to decide between
in_be32/inl ?

--
Bye, Peter Korsgaard
