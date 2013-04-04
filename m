Return-Path: <paulus@ozlabs.org>
Date: Thu, 4 Apr 2013 15:19:24 +1100
From: Paul Mackerras <paulus@samba.org>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 4/11] Update firmware_has_feature() to check
 architecture bits
Message-ID: <20130404041924.GD19443@drongo>
References: <51509AE8.8070803@linux.vnet.ibm.com>
 <51509D7E.5060101@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51509D7E.5060101@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 25, 2013 at 01:54:54PM -0500, Nathan Fontenot wrote:
> The firmware_has_feature() function makes it easy to check for supported
> features of the hypervisor. This patch extends the capability of the
> firmware_has_feature() function to include checking for specified bits
> in vector 5 of the architecture vector as is reported in the device tree.
> 
> As part of this the #defines used for the architecture vector are
> moved to prom.h and re-defined such that the vector 5 options have the vector
> index and the feature bits encoded into them. This makes for a much
> simpler design to add bits from the architecture vector to be added to
> the checking done in firmware_has_feature().
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Acked-by: Paul Mackerras <paulus@samba.org>

The inner loop in fw_vec5_feature_init is perhaps a bit less efficient
than it could be, but I don't imagine it's going to take a noticeable
amount of time.

Paul.
