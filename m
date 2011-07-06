Return-Path: <anton@samba.org>
Date: Wed, 6 Jul 2011 17:49:07 +1000
From: Anton Blanchard <anton@samba.org>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: Re: [RFC] [PATCH] hvc_console: improve tty/console put_chars handling
Message-ID: <20110706174907.25c57973@kryten>
In-Reply-To: <20110705142844.GA2514@linux.vnet.ibm.com>
References: <20110704205738.742e56d0@kryten>
	<1309787787.14501.268.camel@pasglop>
	<20110704142429.GA2147@linux.vnet.ibm.com>
	<CAOZdJXW0Lota0ZuEnOHhsU93v7WmvYztEMyfg+UsMKxFdoXNXQ@mail.gmail.com>
	<1309846963.14501.270.camel@pasglop>
	<20110705142844.GA2514@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Tabi Timur-B04825 <B04825@freescale.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"borntraeger@de.ibm.com" <borntraeger@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Hendrik,

> So with the patch below, the backend can now indirectly control the
> way console output is handled for it.  I still have to think if this
> solution is ok or if it is better to introduce a new callback to
> console output only (and might provide a default implemenatation
> similar to the patch below).
> 
> NOTE: I did not yet test this patch but will do.. I just want to
> share it early to get feedback from you.

Thanks a lot for this. I added the pseries bits and tested it, patches
to follow.

Anton
