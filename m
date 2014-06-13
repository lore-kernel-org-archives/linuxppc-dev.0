Return-Path: <cl@gentwo.org>
Received: from qmta05.emeryville.ca.mail.comcast.net
 (qmta05.emeryville.ca.mail.comcast.net [76.96.30.48])
 by lists.ozlabs.org (Postfix) with ESMTP id EF1931A0516
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jun 2014 11:56:07 +1000 (EST)
Date: Thu, 12 Jun 2014 20:56:00 -0500 (CDT)
From: Christoph Lameter <cl@gentwo.org>
To: David Laight <David.Laight@ACULAB.COM>
Subject: RE: Kernel build issues after yesterdays merge by Linus
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1725BABB@AcuExch.aculab.com>
Message-ID: <alpine.DEB.2.10.1406122055220.19271@gentwo.org>
References: <alpine.DEB.2.10.1406111013580.8422@gentwo.org>
 <20140612220912.3447677f@kryten>
 <063D6719AE5E284EB5DD2968C1650D6D1725BABB@AcuExch.aculab.com>
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Rusty Russell <rusty@rustcorp.com.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 'Anton Blanchard' <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Goobledieguy due to missing Mime header.

On Thu, 12 Jun 2014, David Laight wrote:

> RnJvbTogQW50b24gQmxhbmNoYXJkDQouLi4NCj4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9i
> b290L2luc3RhbGwuc2ggYi9hcmNoL3Bvd2VycGMvYm9vdC9pbnN0YWxsLnNoDQo+IGluZGV4IGI2
> YTI1NmIuLmUwOTZlNWEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcG93ZXJwYy9ib290L2luc3RhbGwu
> c2gNCj4gKysrIGIvYXJjaC9wb3dlcnBjL2Jvb3QvaW5zdGFsbC5zaA0KPiBAQCAtMjMsOCArMjMs
> OCBAQCBzZXQgLWUNCj4gDQo+ICAjIFVzZXIgbWF5IGhhdmUgYSBjdXN0b20gaW5zdGFsbCBzY3Jp
> cHQNCj4gDQo+IC1pZiBbIC14IH4vYmluLyR7SU5TVEFMTEtFUk5FTH0gXTsgdGhlbiBleGVjIH4v
> YmluLyR7SU5TVEFMTEtFUk5FTH0gIiRAIjsgZmkNCj4gLWlmIFsgLXggL3NiaW4vJHtJTlNUQUxM
> S0VSTkVMfSBdOyB0aGVuIGV4ZWMgL3NiaW4vJHtJTlNUQUxMS0VSTkVMfSAiJEAiOyBmaQ0KPiAr
> aWYgWyAteCB+L2Jpbi8ke0lOU1RBTExLRVJORUx9IF07IHRoZW4gZXhlYyB+L2Jpbi8ke0lOU1RB
> TExLRVJORUx9ICQxICQyICQzICQ0OyBmaQ0KPiAraWYgWyAteCAvc2Jpbi8ke0lOU1RBTExLRVJO
> RUx9IF07IHRoZW4gZXhlYyAvc2Jpbi8ke0lOU1RBTExLRVJORUx9ICQxICQyICQzICQ0OyBmaQ0K
> DQpZb3UgcHJvYmFibHkgd2FudCB0byBlbmNsb3NlIHRoZSAkMSBpbiAiIGFzOg0KDQo+ICtpZiBb
> IC14IC9zYmluLyR7SU5TVEFMTEtFUk5FTH0gXTsgdGhlbiBleGVjIC9zYmluLyR7SU5TVEFMTEtF
> Uk5FTH0gIiQxIiAiJDIiICIkMyIgIiQ0IjsgZmkNCg0KCURhdmlkDQoNCg==
>
