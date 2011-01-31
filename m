Return-Path: <sam@ravnborg.org>
Date: Mon, 31 Jan 2011 21:34:49 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/3] dt: documentation reorganization
Message-ID: <20110131203449.GA4199@merkur.ravnborg.org>
References: <20110131073918.9058.37628.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110131073918.9058.37628.stgit@localhost6.localdomain6>
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 31, 2011 at 12:44:41AM -0700, Grant Likely wrote:
> This series reorganizes and cleans up the device tree documentation
> to make the directory useful for non-powerpc users.

Looks better than first try. But the structure is very flat.
Did you consider an arch/* for all arch specific stuff?

	Sam
