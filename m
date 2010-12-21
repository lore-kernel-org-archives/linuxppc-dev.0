Return-Path: <mmarek@suse.cz>
Message-ID: <4D10B8AA.3070500@suse.cz>
Date: Tue, 21 Dec 2010 15:24:42 +0100
From: Michal Marek <mmarek@suse.cz>
MIME-Version: 1.0
To: dirk.brandewie@gmail.com
Subject: Re: [PATCH 1/4] of: Add support for linking device tree blobs into
	vmlinux
References: <cover.1291820033.git.dirk.brandewie@gmail.com>
	<99ff131ecbee621f0d3178d6d3896d6f39207d6f.1291820034.git.dirk.brandewie@gmail.com>
In-Reply-To: <99ff131ecbee621f0d3178d6d3896d6f39207d6f.1291820034.git.dirk.brandewie@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Cc: linux-arch@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, sodaville@linutronix.de,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 8.12.2010 16:01, dirk.brandewie@gmail.com wrote:
> +quiet_cmd_dt_S_dtb= DTB    $@

> +quiet_cmd_dtc = DTC $@

Hi,

just an aesthetic remark: The target name should start at the 9th
column, so there should be 5 spaces after both "DTB" and "DTC".

Michal
