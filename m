Return-Path: <paulus@ozlabs.org>
Date: Thu, 25 Apr 2013 16:25:39 +1000
From: Paul Mackerras <paulus@samba.org>
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Subject: Re: "attempt to move .org backwards" still show up
Message-ID: <20130425062539.GA421@iris.ozlabs.ibm.com>
References: <5177965D.9090406@linux.vnet.ibm.com>
 <20130424083142.GB26834@concordia>
 <51779941.8080403@linux.vnet.ibm.com>
 <30651.1366799858@ale.ozlabs.ibm.com>
 <1366807638.5911.2.camel@localhost> <5178816D.3000309@asianux.com>
 <5178ABA2.4030109@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5178ABA2.4030109@linux.vnet.ibm.com>
Cc: sfr@canb.auug.org.au, Michael Neuling <mikey@neuling.org>, matt@ozlabs.org,
 Chen Gang <gang.chen@asianux.com>, linux-kernel@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 25, 2013 at 12:05:54PM +0800, Mike Qiu wrote:
> This has block my work now
> So I hope you can take a look ASAP
> Thanks
> :)
> 
> Mike

As a quick fix, turn on CONFIG_KVM_BOOK3S_64_HV.  That will eliminate
the immediate problem.

Paul.
