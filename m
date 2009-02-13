Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 002/002] de2104x: support for systems lacking cache
	coherence
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Risto Suominen <risto.suominen@gmail.com>
In-Reply-To: <46e1c7760902120322r11cffbdcgff330a242ca586fb@mail.gmail.com>
References: <46e1c7760902120322r11cffbdcgff330a242ca586fb@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 13 Feb 2009 14:26:30 +1100
Message-Id: <1234495590.26036.1.camel@pasglop>
Mime-Version: 1.0
Cc: LinuxPPC-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-02-12 at 13:22 +0200, Risto Suominen wrote:
> Here is a patch that helped me to get my de2104x NIC working on my
> PowerMac 5500. As an interesting side effect, it also made my mesh
> module crash.

Can you tell me more about the mesh crash ? Do you have a log ?

Ben.
