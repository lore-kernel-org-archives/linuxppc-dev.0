Return-Path: <anton@samba.org>
Date: Fri, 28 Mar 2014 09:04:58 +1100
From: Anton Blanchard <anton@samba.org>
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4] powerpc/powernv: Fix little endian issues OPAL
 error log code
Message-ID: <20140328090458.6da932af@kryten>
In-Reply-To: <87ob0supw1.fsf@river.i-did-not-set--mail-host-address--so-tickle-me>
References: <20140327161849.791432d0@kryten> <20140327162056.5a57c4c9@kryten>
 <87ob0supw1.fsf@river.i-did-not-set--mail-host-address--so-tickle-me>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Stewart,

> Do we also need any magic for the getting of error logs themselves?
> 
> You may want to check the md5 of the logs themselves on be and le.

Good idea. An md5 of the logs in LE and BE on this box checks out, so I
think we are good.

Anton
