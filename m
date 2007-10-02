Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by ozlabs.org (Postfix) with ESMTP id BC29DDDF81
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 02:46:36 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so5364513wag
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Oct 2007 09:46:35 -0700 (PDT)
Message-ID: <fa686aa40710020946t68fa2ab1sb36e07210e95426a@mail.gmail.com>
Date: Tue, 2 Oct 2007 10:46:35 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com, jacmet@sunsite.dk
Subject: Re: [PATCH 2/2] Uartlite: Revert register io access changes
In-Reply-To: <20071002164421.24562.33312.stgit@trillian.cg.shawcable.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071002164415.24562.44426.stgit@trillian.cg.shawcable.net>
	<20071002164421.24562.33312.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/2/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> Reverts commit 58205d2b1256a32c9e8b02587f8ef3cdcf1eb8bd
>
> This driver is used by devices other than the xilinx opb-uartlite which
> depend on bytewise access to the registers.  The change to 32 bit access
> does not work on these devices.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
>  0 files changed, 0 insertions(+), 0 deletions(-)

Oops.... let me try that again.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
