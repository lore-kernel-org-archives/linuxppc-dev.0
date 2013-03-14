Return-Path: <paulus@ozlabs.org>
Date: Thu, 14 Mar 2013 19:49:39 +1100
From: Paul Mackerras <paulus@samba.org>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/11] Expose pseries devicetree_update()
Message-ID: <20130314084939.GA9841@iris.ozlabs.ibm.com>
References: <513AB2E3.6090209@linux.vnet.ibm.com>
 <513AB39E.8000504@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <513AB39E.8000504@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 08, 2013 at 09:59:26PM -0600, Nathan Fontenot wrote:
> From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
> 
> When rtasd receives a PRRN event, it needs to make a series of RTAS
> calls (ibm,update-nodes and ibm,update-properties) to retrieve the
> updated device tree information. These calls are already handled in the
> pseries_devtree_update() routine used in partition migration.
> 
> This patch simply exposes pseries_devicetree_update() so it can be
> called by rtasd. pseries_devicetree_update() and supporting functions
> are also modified to take a 32-bit 'scope' parameter. This parameter is
> required by the ibm,update-nodes/ibm,update-properties RTAS calls, and
> the appropriate value is contained within the RTAS event for PRRN
> notifications. In pseries_devicetree_update() it was previously
> hard-coded to 1, the scope value for partition migration.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Patch looks fine, so:

Acked-by: Paul Mackerras <paulus@samba.org>

However, you could usefully put some of the description from your 0/11
email into this patch description, since the 0/11 email doesn't get
preserved in git.

Paul.
