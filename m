Return-Path: <paulus@ozlabs.org>
Date: Thu, 6 Sep 2012 11:24:10 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V7 04/12] arch/powerpc: Convert virtual address to vpn
Message-ID: <20120906012410.GF22688@bloggs.ozlabs.ibm.com>
References: <1346749289-16986-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1346749289-16986-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20120905082629.GB22688@bloggs.ozlabs.ibm.com>
 <87392wcyvc.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87392wcyvc.fsf@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 05, 2012 at 08:15:11PM +0530, Aneesh Kumar K.V wrote:
> 
> One of the reason i avoided va -> vpn rename is to avoid unnecessary
> hunks. But then what i can do is to apply the name to those part of the
> hunks which is being touched in this patch. Will that help. Or do you
> want me to fold the two patches ?

Either would do, whichever is easier for you.

Paul.
