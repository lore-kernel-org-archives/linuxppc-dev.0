Return-Path: <paulus@ozlabs.org>
Date: Thu, 4 Apr 2013 15:20:39 +1100
From: Paul Mackerras <paulus@samba.org>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 5/11] Update numa.c to use updated
 firmware_has_feature()
Message-ID: <20130404042039.GE19443@drongo>
References: <51509AE8.8070803@linux.vnet.ibm.com>
 <51509DC5.3020007@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51509DC5.3020007@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 25, 2013 at 01:56:05PM -0500, Nathan Fontenot wrote:
> Update the numa code to use the updated firmware_has_feature() when checking
> for type 1 affinity.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Acked-by: Paul Mackerras <paulus@samba.org>
