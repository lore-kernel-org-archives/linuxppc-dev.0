Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKXtj1szYzDrK4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 15:34:53 +1000 (AEST)
Received: by mail-wm0-x243.google.com with SMTP id q128so5741860wma.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Aug 2016 22:34:53 -0700 (PDT)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <CANtoAtN1K3OAoXsgeMOWui_jEZO3X1fJAmRX-LeO_Du8h3T9kg@mail.gmail.com>
References: <CANtoAtPSgkxEvAdOs-gZGOECYN8OFTvwRrsg+US41ji1fGEDLA@mail.gmail.com>
 <969BB53B-CB30-49DC-B6C5-4D2381ECE6EE@gmail.com>
 <CANtoAtN1K3OAoXsgeMOWui_jEZO3X1fJAmRX-LeO_Du8h3T9kg@mail.gmail.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Thu, 25 Aug 2016 07:34:28 +0200
Message-ID: <CA+7wUsxDUfSHGFzrJtNBNmdwvOrJG4O4NL8_B18dJrdoDGfDtQ@mail.gmail.com>
Subject: Re: PowerPC agpmode issues
To: Mike <michael.heltne@gmail.com>
Cc: "Herminio Hernandez Jr." <herminio.hernandezjr@gmail.com>,
 Pranith Kumar <bobby.prani@gmail.com>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 25, 2016 at 5:09 AM, Mike <michael.heltne@gmail.com> wrote:
> Any improvement on your ends? Seems -1 is now the quirk. But does your
> trackpads work? Did an update after getting a new and the latest released
> powerbook up. Also found an interesting interface which can replace our ide
> drives, intended for ipod classics, but it can fit in the bay and has msata
> interface.

You should subscribe to this bug:

https://bugs.freedesktop.org/show_bug.cgi?id=94757

that's the only possible solution (when it comes out) AFAIK.
