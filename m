Return-Path: <glikely@secretlab.ca>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 55C5AB6FC4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2012 08:36:26 +1000 (EST)
Received: by obbuo19 with SMTP id uo19so69204obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2012 15:36:23 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1335220202-32533-1-git-send-email-grant.likely@secretlab.ca>
References: <1335220202-32533-1-git-send-email-grant.likely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 23 Apr 2012 16:36:03 -0600
Message-ID: <CACxGe6ua32AL_wzaLvjBWx3T5ipF=JdHs46E+baddn_NLxG5kg@mail.gmail.com>
Subject: [PATCH v2 0/2] Get rid of PowerPC users of NR_IRQS
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joakim Tjernlund <joakim.tjernlund@transmode.se>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Oops. Flubbed the subject on the below email.  This is the cover
letter for the NR_IRQS patches, so the subject should have included
"[PATCH v2 0/2]"

On Mon, Apr 23, 2012 at 4:30 PM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
> Hi Ben,
>
> Here's the 2nd version of the NR_IRQS cleanup patches for PowerPC. =A0I'v=
e
> addressed your comments and compile tested them, but I've not tried to
> boot. =A0If they check out for you then they should probably go into v3.4=
.
>
> g.
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
