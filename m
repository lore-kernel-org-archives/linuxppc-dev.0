Return-Path: <michael@ellerman.id.au>
Date: Mon, 15 Apr 2013 21:42:02 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
Subject: Re: [PATCHv3 1/2] ppc64: perform proper max_bus_speed detection
Message-ID: <20130415114202.GA12701@concordia>
References: <1365685994-32603-1-git-send-email-lucaskt@linux.vnet.ibm.com>
 <1365685994-32603-2-git-send-email-lucaskt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365685994-32603-2-git-send-email-lucaskt@linux.vnet.ibm.com>
Cc: David Airlie <airlied@linux.ie>, Brian King <brking@linux.vnet.ibm.com>,
 dri-devel@lists.freedesktop.org,
 Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>,
 Alex Deucher <alexander.deucher@amd.com>, Jerome Glisse <jglisse@redhat.com>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 11, 2013 at 10:13:13AM -0300, Lucas Kannebley Tavares wrote:
> On pseries machines the detection for max_bus_speed should be done
> through an OpenFirmware property. This patch adds a function to perform this
> detection and a hook to perform dynamic adding of the function only for
> pseries.

This fails to build for me on ppc64_defconfig, with:

arch/powerpc/include/asm/machdep.h:111:5: error: 'struct pci_host_bridge' declared inside parameter list [-Werror]


Presumably you tested it using some other defconfig?

cheers
