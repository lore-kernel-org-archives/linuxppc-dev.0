Return-Path: <whitebox@nefkom.net>
From: Andreas Schwab <schwab@linux-m68k.org>
To: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] dtc: Ensure #line directives don't consume data from the
 next line
References: <1370020450-18136-1-git-send-email-swarren@wwwdotorg.org>
Date: Fri, 31 May 2013 19:38:57 +0200
In-Reply-To: <1370020450-18136-1-git-send-email-swarren@wwwdotorg.org>
 (Stephen Warren's message of "Fri, 31 May 2013 11:14:10 -0600")
Message-ID: <87sj13dp72.fsf@hase.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: mmarek@suse.cz, jdl@jdl.com, Stephen Warren <swarren@nvidia.com>,
 linux-kbuild@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, rob.herring@calxeda.com,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stephen Warren <swarren@wwwdotorg.org> writes:

> Fix this by replacing {WS} with [ \t] so that it can't match line-breaks.

I think the other uses of {WS} shouldn't span lines either.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
