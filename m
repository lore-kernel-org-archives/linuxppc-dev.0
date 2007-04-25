Return-Path: <benh@kernel.crashing.org>
Subject: RE: PTE entries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Siva Prasad <sprasad@bivio.net>
In-Reply-To: <D83235F0F3C86D4D889D8B9A0DA8C6D762CA85@corpexc01.corp.networkrobots.com>
References: <D83235F0F3C86D4D889D8B9A0DA8C6D762C6C3@corpexc01.corp.networkrobots.com>
	<1177376700.14873.40.camel@localhost.localdomain>
	<D83235F0F3C86D4D889D8B9A0DA8C6D762CA85@corpexc01.corp.networkrobots.com>
Content-Type: text/plain
Date: Wed, 25 Apr 2007 13:50:08 +1000
Message-Id: <1177473008.14873.181.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-04-24 at 20:34 -0700, Siva Prasad wrote:
> Thanks Ben.
> 
> I managed to fix this. I am working on how best we can rewrite the self
> modifying code we have for create_hpte routine. I would prefer to read
> from SDR1, than to hardcode (or self modify the code) the way it is done
> now.
> 
> Feel free to let me know what you think.

Self-modifying allows better performances in that very critical code path...

Why would you need to change that code anyway ?

Ben.
