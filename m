Return-Path: <michael@ellerman.id.au>
Date: Mon, 15 Apr 2013 17:20:27 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/8] Remove syslog prefix in uncompressed oops text
Message-ID: <20130415072027.GA30156@concordia>
References: <20130410071835.20150.56489.stgit@aruna-ThinkPad-T420>
 <20130410072100.20150.74661.stgit@aruna-ThinkPad-T420>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130410072100.20150.74661.stgit@aruna-ThinkPad-T420>
Cc: jkenisto@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 10, 2013 at 12:51:00PM +0530, Aruna Balakrishnaiah wrote:
> Removal of syslog prefix in the uncompressed oops text will
> help in capturing more oops data.

Why does it help? Does this effect any existing tools?

cheers
